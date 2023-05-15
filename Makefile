deploy:
	hugo
	rsync -avx --delete public/ deploy:./www/tarneo.fr/

