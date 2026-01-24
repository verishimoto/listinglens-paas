import os
import shutil
import subprocess
import sys

# Configuration
# Script is in tools/, so project root is one level up
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_ROOT = os.path.dirname(SCRIPT_DIR)
MAIN_DART_PATH = os.path.join(PROJECT_ROOT, "lib/main.dart")
DEPLOY_ROOT = os.path.join(PROJECT_ROOT, "deploy")
BUILD_OUTPUT = os.path.join(PROJECT_ROOT, "build/web")

PROTOCOLS = [
    {
        "name": "alpha",
        "import": "package:listing_lens_paas/features/alpha/alpha_dashboard.dart",
        "home": "const AlphaDashboard()",
        "href": "/listing_lens_paas/alpha/",
    },
    {
        "name": "beta",
        "import": "package:listing_lens_paas/features/beta/beta_flow.dart",
        "home": "const BetaFlow()",
        "href": "/listing_lens_paas/beta/",
    },
    {
        "name": "gamma",
        "import": "package:listing_lens_paas/features/gamma/gamma_input.dart",
        "home": "const GammaInput()",
        "href": "/listing_lens_paas/gamma/",
    }
]

def backup_main():
    print("Backing up main.dart...")
    shutil.copy(MAIN_DART_PATH, MAIN_DART_PATH + ".bak")

def restore_main():
    if os.path.exists(MAIN_DART_PATH + ".bak"):
        print("Restoring main.dart...")
        shutil.copy(MAIN_DART_PATH + ".bak", MAIN_DART_PATH)
        os.remove(MAIN_DART_PATH + ".bak")

def modify_main(protocol):
    print(f"Modifying main.dart for {protocol['name']}...")
    with open(MAIN_DART_PATH, "r") as f:
        content = f.read()
    
    # Imports
    # We replace the default Trinity import with the specific protocol import
    # Default: import 'package:listing_lens_paas/features/trinity_dashboard.dart';
    
    if "features/trinity_dashboard.dart" in content:
        content = content.replace(
            "package:listing_lens_paas/features/trinity_dashboard.dart", 
            protocol['import'].replace("package:listing_lens_paas/", "package:listing_lens_paas/") # ensure full package path match
        )
        # Also clean up just in case it was a relative import in some versions
        content = content.replace(
            "import 'features/trinity_dashboard.dart';", 
            f"import '{protocol['import']}';"
        )

    # Home
    # Default: home: const TrinityDashboard(),
    if "home: const TrinityDashboard()" in content:
        content = content.replace("home: const TrinityDashboard()", f"home: {protocol['home']}")
    
    with open(MAIN_DART_PATH, "w") as f:
        f.write(content)

def build_web(base_href):
    print(f"Building for {base_href}...")
    # Clean build dir first to ensure no stale files
    if os.path.exists(BUILD_OUTPUT):
        shutil.rmtree(BUILD_OUTPUT)
        
    cmd = ["flutter", "build", "web", "--release", "--base-href", base_href, "--no-tree-shake-icons"]
    
    # On Windows, we need shell=True for some envs, but subprocess.run usually handles list args fine.
    # However, for flutter on windows sometimes shell=True is safer.
    is_windows = sys.platform.startswith('win')
    subprocess.run(cmd, check=True, cwd=PROJECT_ROOT, shell=is_windows)

def deploy_folder(target_subpath):
    target_dir = os.path.join(DEPLOY_ROOT, target_subpath) if target_subpath else DEPLOY_ROOT
    
    # If deploying to root, we don't want to wipe the whole deploy folder if it has subfolders already?
    # Actually, we should probably build root last or first.
    # Let's say we build root first.
    
    if target_subpath:
        # For subfolders: clean if exists
        if os.path.exists(target_dir):
            shutil.rmtree(target_dir)
        # shutil.copytree requires dest to NOT exist usually, or dirs_exist_ok in newer python
        shutil.copytree(BUILD_OUTPUT, target_dir)
    else:
        # For root: copy contents of build/web to deploy/ 
        # But wait, if deploy/alpha exists, we don't want to nuke it.
        # So we iterate and copy files.
        if not os.path.exists(DEPLOY_ROOT):
            os.makedirs(DEPLOY_ROOT)
            
        for item in os.listdir(BUILD_OUTPUT):
            s = os.path.join(BUILD_OUTPUT, item)
            d = os.path.join(DEPLOY_ROOT, item)
            if os.path.isdir(s):
                # if main build has a folder that conflicts with sub-builds (unlikely, e.g. 'alpha' folder in root build?)
                # usually flutter build has 'assets', 'icons', 'canvaskit' etc.
                if os.path.exists(d):
                    shutil.rmtree(d)
                shutil.copytree(s, d)
            else:
                shutil.copy2(s, d)
    
    print(f"Deployed to {target_dir}")

def run():
    print("--- Starting Trinity Deployment Pipeline ---")
    
    # Clean deploy root initially
    if os.path.exists(DEPLOY_ROOT):
        shutil.rmtree(DEPLOY_ROOT)
    os.makedirs(DEPLOY_ROOT)

    backup_main()
    
    try:
        # 1. Build HUB (Root)
        # Corresponds to current main.dart (TrinityDashboard)
        print("\n=== Building HUB (Root) ===")
        build_web("/listing_lens_paas/")
        deploy_folder("") # Copy to root of deploy/
        
        # 2. Build Protocols
        for p in PROTOCOLS:
            print(f"\n=== Building Protocol: {p['name'].upper()} ===")
            restore_main() # Ensure clean slate
            modify_main(p)
            build_web(p['href'])
            deploy_folder(p['name'])
            
    except Exception as e:
        print(f"\n!!! Error during deployment: {e}")
        # Re-raise to fail CI
        raise e 
    finally:
        print("\nCleaning up...")
        restore_main()
        print("Done.")

if __name__ == "__main__":
    run()
