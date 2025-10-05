.PHONY: dev test build sd deploy format

dev:
	hugo server -D --disableFastRender --minify

test:
	# Verify there are no top-level headings in blog posts, but still allow comments in code blocks :D
	find content/posts/ -type f -name "*.md" -exec cat '{}' \; | sed -E '/```/,/```/d' | grep -E "^# " && exit 1 || true
	bash check-links.sh 2>/dev/null

build:
	if [ -n "$$(git ls-files --deleted --modified --others --exclude-standard)" ]; then \
		echo "You have unstaged changes, refusing to build."; \
		echo "You can:"; \
		echo "- Deploy while stashing changes with \"make sd\""; \
		echo "- Stage the files before building again"; \
		exit 1; \
	fi
	hugo --cleanDestinationDir --minify

sd:
	git stash --include-untracked
	make deploy
	git stash pop

deploy: build
	rsync -qavx --delete public/ tarneo@ssh.renn.es:www/tarneo.fr/

format:
	prettier content --write
