dev:
	hugo server -D --disableFastRender

test:
	# Verify there are no top-level headings in blog posts, but still allow comments in code blocks :D
	find content/posts/ -type f -name "*.md" -exec cat '{}' \; | sed -E '/```/,/```/d' | grep -E "^# " && exit 1 || true
	bash check-links.sh 2>/dev/null

build:
	git stash --include-untracked # Don't deploy drafts of changes
	hugo --cleanDestinationDir
	git stash pop

deploy: build
	rsync -avx --delete public/ tarneo@cocinero:./www/
