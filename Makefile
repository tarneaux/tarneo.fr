deploy:
	# Verify there are no top-level headings in blog posts
	grep -r '^# ' content/posts/ && exit 1 || true
	hugo
	rsync -avx --delete public/ cocinero-tarneo:./www/

