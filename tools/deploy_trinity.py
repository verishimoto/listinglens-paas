import os
import shutil
import subprocess
import sys

# Configuration
PROJECT_ROOT = "c:/Users/veris/.gemini/antigravity/scratch/listing_lens_paas"
MAIN_DART_PATH = os.path.join(PROJECT_ROOT, "lib/main.dart")
DEPLOY_ROOT = os.path.join(PROJECT_ROOT, "deploy")
BUILD_OUTPUT = os.path.join(PROJECT_ROOT, "build/web")

# Original Import: import 'features/trinity_dashboard.dart';
# Original Home: home: const TrinityDashboard(),

PROTOCOLS = [
    {
        "name": "alpha",
        "import": "package:listing_lens_paas/features/alpha/alpha_dashboard.dart",
        "home": "const AlphaDashboard()",
        "href": "/alpha/",
    },
    {
        "name": "beta",
        "import": "package:listing_lens_paas/features/beta/beta_flow.dart",
        "home": "const BetaFlow()",
        "href": "/beta/",
    },
    {
        "name": "gamma",
        "import": "package:listing_lens_paas/features/gamma/gamma_input.dart",
        "home": "const GammaInput()",
        "href": "/gamma/",
    }
]

def backup_main():
    shutil.copy(MAIN_DART_PATH, MAIN_DART_PATH + ".bak")

def restore_main():
    if os.path.exists(MAIN_DART_PATH + ".bak"):
        shutil.copy(MAIN_DART_PATH + ".bak", MAIN_DART_PATH)
        os.remove(MAIN_DART_PATH + ".bak")

def modify_main(protocol):
    with open(MAIN_DART_PATH, "r") as f:
        content = f.read()
    
    # Replace Import
    # We want to keep original imports but add the specific one
    # Actually, simpler to just replace "features/trinity_dashboard.dart" line if it exists
    # or just add the new import at the top
    
    new_import = f"import '{protocol['import']}';"
    
    # Simple replace for 'home:'
    # We assume file has "home: const TrinityDashboard()," or similar
    
    if "features/trinity_dashboard.dart" in content:
        content = content.replace("import 'features/trinity_dashboard.dart';", new_import)
    
    if "home: const TrinityDashboard()" in content:
        content = content.replace("home: const TrinityDashboard()", f"home: {protocol['home']}")
    
    with open(MAIN_DART_PATH, "w") as f:
        f.write(content)

def build_web(base_href):
    # base-href needs to be relative ./ for file system opening or specific path
    # If using absolute file paths, ./ is safest if index.html is in the dir
    print(f"Building for {base_href}...")
    subprocess.run(["flutter", "build", "web", "--release", "--base-href", base_href], check=True, cwd=PROJECT_ROOT, shell=True)

def deploy(name):
    target_dir = os.path.join(DEPLOY_ROOT, name)
    if os.path.exists(target_dir):
        shutil.rmtree(target_dir) # Clean existing
    shutil.copytree(BUILD_OUTPUT, target_dir)
    print(f"Deployed to {target_dir}")

def run():
    print("Starting Trinity Deployment...")
    backup_main()
    
    try:
        for p in PROTOCOLS:
            print(f"--- Deploying {p['name'].upper()} ---")
            restore_main() # Reset first
            modify_main(p)
            
            # Using specific href
            build_web(p['href']) 
            
            deploy(p['name'])
            
    except Exception as e:
        print(f"Error: {e}")
    finally:
        print("Restoring original main.dart...")
        restore_main()
        print("Done.")

if __name__ == "__main__":
    run()
