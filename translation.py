import argparse
from pathlib import Path
import json

def convertToJson():
    contentPath = Path(__file__).parent / 'content'

    for contentFile in contentPath.glob('**/*'):
        if contentFile.suffix != '.lr':
            continue
        with open(contentFile, 'r') as content_file:
            contents = content_file.read().split('\n---\n')

        results = {}
        for content in contents:
            contentTyp, text = content.split(':', maxsplit=1)
            results[contentTyp.strip()] = text

        with open(contentFile.with_suffix('.json'), 'w') as tr_file:
            json.dump(results, tr_file, indent=2, ensure_ascii=False)

def convertToLr():
    contentPath = Path(__file__).parent / 'content'

    for contentFile in contentPath.glob('**/*'):
        if contentFile.suffix != '.json':
            continue

        with open(contentFile, 'r') as tr_file:
            translations = json.load(tr_file)

        translationList = []
        for contentTyp, text in translations.items():
            translationList.append(':'.join([contentTyp, text]))

        contents = '\n---\n'.join(translationList).rstrip() + '\n'

        with open(contentFile.with_suffix('.lr'), 'w') as content_file:
            content_file.write(contents)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Convert between json translation files and lektor content files")
    parser.add_argument('--json', action='store_true', help='convert lektor content files to json files')
    parser.add_argument('--lr', action='store_true', help='convert translation files back to lektor content files')

    args = parser.parse_args()

    if args.json:
        convertToJson()

    if args.lr:
        convertToLr()
