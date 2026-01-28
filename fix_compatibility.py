import os
import re

def fix_files(directory):
    # Regex to find .withOpacity(value) and replace with .withValues(alpha: value)
    # Pattern: .withOpacity(<content>)
    pattern = re.compile(r'\.withOpacity\(([^)]+)\)')
    
    count = 0
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith(".dart"):
                path = os.path.join(root, file)
                try:
                    with open(path, 'r', encoding='utf-8') as f:
                        content = f.read()
                    
                    new_content, n = pattern.subn(r'.withValues(alpha: \1)', content)
                    
                    if n > 0:
                        print(f"Fixing {n} instances in: {file}")
                        with open(path, 'w', encoding='utf-8') as f:
                            f.write(new_content)
                        count += n
                except Exception as e:
                    print(f"Error processing {file}: {e}")

    print(f"Total fixes applied: {count}")

if __name__ == "__main__":
    target_dir = r"c:\Users\veris\.gemini\antigravity\scratch\listing_lens_paas\lib"
    print(f"Scanning {target_dir}...")
    fix_files(target_dir)
