test:
	# Verify there are no top-level headings in blog posts, but still allow comments in code blocks :D
	find content/posts/ -type f -name "*.md" -exec cat '{}' \; | sed -E '/```/,/```/d' | grep -E "^# " && exit 1 || true
	# bash check-links.sh 2>/dev/null

build:
	hugo

deploy:
	sed -i "s/baseURL: 'https:\/\/draft.tarneo.fr\//baseURL: 'https:\/\/tarneo.fr\//g" config.yaml || true
	grep -q "baseURL: 'https://tarneo\.fr/'" config.yaml
	make test build
	rsync -avx --delete public/ cocinero-tarneo:./www/

draft:
	sed -i "s/baseURL: 'https:\/\/tarneo.fr\//baseURL: 'https:\/\/draft.tarneo.fr\//g" config.yaml || true
	grep -q "baseURL: 'https://draft\.tarneo\.fr/'" config.yaml
	make test build
	rsync -avx --delete public/ cocinero-tarneo:./www-draft/
