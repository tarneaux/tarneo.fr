test:
	# Verify there are no top-level headings in blog posts, but still allow comments in code blocks :D
	find content/posts/ -type f -name "*.md" -exec cat '{}' \; | sed -E '/```/,/```/d' | grep -E "^# " && exit 1 || true
	bash check-links.sh 2>/dev/null

build:
	hugo

deploy: build
	rsync -avx --delete public/ tarneo@cocinero:./www/
