dev:
	hugo server -D --disableFastRender

test:
	# Verify there are no top-level headings in blog posts, but still allow comments in code blocks :D
	find content/posts/ -type f -name "*.md" -exec cat '{}' \; | sed -E '/```/,/```/d' | grep -E "^# " && exit 1 || true
	bash check-links.sh 2>/dev/null

build:
	if [[ $$(git status --porcelain) ]]; then \
		echo "You have unstaged changes, please stash first"; \
		echo "Run the \`sd\` target to stack and deploy."; \
		exit 1; \
	fi
	hugo --cleanDestinationDir

sd:
	git stash --include-untracked
	make deploy
	git stash pop

deploy: build
	rsync -avx --delete public/ tarneo@cocinero:./www/

format:
	prettier content --write
