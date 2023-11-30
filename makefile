setup:
	# setup the project
	flutter pub get
	make gen_code
run:
	# run the app
	flutter run
gen_code:
	# generate the generated code
	dart run build_runner build --delete-conflicting-outputs