import sys, subprocess

VERSION_DICT = {
    "0.15": "2.0.1",
    "0.14": "1.13.1",
    "0.13": "1.12.1",
    "0.12": "1.11.0",
    "0.11": "1.10.2",
    "0.10": "1.9.1",
    "0.9": "1.8.2",
    "0.8": "1.7.1",
    "0.7": "1.6.0",
    "0.6": "1.5.1",
    "0.5": "1.4.0",
    "0.4.2": "1.3.1",
    "0.4.3": "1.3.1",
    "0.4.1": "1.2.0",
    "0.4.0": "1.1.0",
    "0.3": "1.1.0",
    "0.2": "1.0.1"
}

version = sys.argv[1]

for key in VERSION_DICT:
    if version.startswith(key):
        exit(subprocess.check_call([sys.executable, "-m", "pip", "install", "torch==" + VERSION_DICT[key]]))

exit(subprocess.check_call([sys.executable, "-m", "pip", "install", "torch==2.0.1"]))
