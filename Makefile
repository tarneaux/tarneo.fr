deploy:
	hugo
	rsync -avx --delete public/ deploy:./tarneo.fr/

