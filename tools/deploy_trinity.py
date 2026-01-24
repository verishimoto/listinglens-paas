import os
import shutil
import subprocess
import sys

# Configuration
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_ROOT = os.path.dirname(SCRIPT_DIR)
DEPLOY_ROOT = os.path.join(PROJECT_ROOT, "deploy")
BUILD_OUTPUT = os.path.join(PROJECT_ROOT, "build/web")

PROTOCOLS = [
    {
        "name": "alpha",
        "target": "lib/main_alpha.dart",
        "href": "/listing_lens_paas/alpha/",
    },
    {
        "name": "beta",
        "target": "lib/main_beta.dart",
        "href": "/listing_lens_paas/beta/",
    },
    {
        "name": "gamma",
        "target": "lib/main_gamma.dart",
        "href": "/listing_lens_paas/gamma/",
    }
]

def build_web(target_file, base_href):
    print(f"Building {target_file} for {base_href}...")
    
    # Clean build dir first to ensure no stale files
    if os.path.exists(BUILD_OUTPUT):
        shutil.rmtree(BUILD_OUTPUT)
        
    cmd = [
        "flutter", "build", "web", 
        "--release", 
        "--base-href", base_href, 
        "--no-tree-shake-icons",
        "-t", target_file
    ]
    
    is_windows = sys.platform.startswith('win')
    # Use shell=True carefully, mostly needed for finding executables in path on Windows
    subprocess.run(cmd, check=True, cwd=PROJECT_ROOT, shell=is_windows)

def deploy_folder(target_subpath):
    target_dir = os.path.join(DEPLOY_ROOT, target_subpath) if target_subpath else DEPLOY_ROOT
    
    if target_subpath:
        # For subfolders: clean if exists
        if os.path.exists(target_dir):
            shutil.rmtree(target_dir)
        print(f"Deploying to subfolder: {target_dir}")
        shutil.copytree(BUILD_OUTPUT, target_dir)
    else:
        # For root: copy contents but don't wipe existing subfolders (like alpha/beta/gamma) if we can help it
        # Actually simplest is to ensure root is built FIRST?
        # If we build root first, we can wipe deploy root.
        print(f"Deploying to root: {target_dir}")
        if not os.path.exists(DEPLOY_ROOT):
            os.makedirs(DEPLOY_ROOT)
            
        for item in os.listdir(BUILD_OUTPUT):
            s = os.path.join(BUILD_OUTPUT, item)
            d = os.path.join(DEPLOY_ROOT, item)
            if os.path.isdir(s):
                if os.path.exists(d):
                    shutil.rmtree(d)
                shutil.copytree(s, d)
            else:
                shutil.copy2(s, d)
    
    print(f"Deployed to {target_dir}")

def deploy_governor():
    print("\n=== Deploying Governor Dashboard ===")
    src = os.path.join(PROJECT_ROOT, "lib/governor/dashboard.html")
    dest_dir = os.path.join(DEPLOY_ROOT, "governor")
    if not os.path.exists(dest_dir):
        os.makedirs(dest_dir)
        
    shutil.copy2(src, os.path.join(dest_dir, "index.html"))
    print(f"Governor deployed to {dest_dir}/index.html")


def run():
    print("--- Starting Trinity Deployment Pipeline (Stable) ---")
    
    # Clean deploy root initially? 
    # Yes, let's start fresh to avoid clutter.
    if os.path.exists(DEPLOY_ROOT):
        print("Cleaning previous deployment...")
        shutil.rmtree(DEPLOY_ROOT)
    os.makedirs(DEPLOY_ROOT)

    try:
        # 1. Build HUB (Root) - Default main.dart
        print("\n=== Building HUB (Root) ===")
        build_web("lib/main.dart", "/listing_lens_paas/")
        deploy_folder("") 
        
        # 2. Build Protocols
        for p in PROTOCOLS:
            print(f"\n=== Building Protocol: {p['name'].upper()} ===")
            build_web(p['target'], p['href'])
            deploy_folder(p['name'])
            
        # 3. Deploy Governor
        deploy_governor()

    except Exception as e:
        print(f"\n!!! Error during deployment: {e}")
        raise e 
    
    print("\nDeployment Complete. No source files were harmed.")

if __name__ == "__main__":
    run()
