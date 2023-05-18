deploy:
	hugo
	rsync -avx --delete public/ cocinero-tarneo:./www/

