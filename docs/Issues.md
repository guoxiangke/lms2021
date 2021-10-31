# Issues.md

- The stream or file "/var/www/html/storage/logs/laravel.log" could not be opened in append mode: Failed to open stream: Permission denied 
	sudo chown 33:33 laravel/storage/logs/ -R
	
- file_put_contents(/var/www/html/storage/framework/sessions/4kmjdFxTtaduLsjTUml7zPzWrBn10TTP20j45chC): Failed to open stream: Permission denied 
	sudo chown 33:33 laravel/storage/ -R

- chown: cannot access 'storage': No such file or directory
	remove laravel/storage in .dockerignore
- Fatal error: Uncaught Error: Failed opening required '/var/www/html/vendor/autoload.php' (include_path='.:/usr/local/lib/php') in /var/www/html/artisan:18
	remove  - ./laravel/vendor:/var/www/html/vendor in docker-compose.yml
	

-  Cannot serve directory /var/www/html/public/: No matching DirectoryIndex (index.php,index.html) found, and server-generated directory index forbidden by Options directive

	
- production.ERROR: No application encryption key has been specified. {"exception":"[object] (Illuminate\\Encryption\\MissingAppKeyException(code: 0): No application encryption key has been specified. at /var/www/html/vendor/laravel/framework/src/Illuminate/Encryption/EncryptionServiceProvider.php:101
	- ./laravel/.env:/var/www/html/.env

