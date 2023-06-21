deploy:
	# Verify there are no top-level headings in blog posts, but still allow comments in code blocks :D
	find content/posts/ -type f -name "*.md" -exec cat '{}' \; | sed -E '/```/,/```/d' | grep -E "^# " && exit 1 || true
	hugo
	rsync -avx --delete public/ cocinero-tarneo:./www/

