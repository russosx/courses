php artisan serve
php artisan migrate:make create_customers_table
php artisan migrate:make create_transactions_table
php artisan migrate
curl -X POST -d "first_name=Jane&last_name=Doe&email=jdoe@gmail.com" http://localhost:8000/customers
curl http://localhost:8000/customers/all