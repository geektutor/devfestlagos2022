.PHONY: gen

run-dev:
	flutter run --flavor development --target lib/main_development.dart -v

run-stg:
	flutter run --flavor staging --target lib/main_staging.dart

run-prod:
	flutter run --flavor production --target lib/main_production.dart

run-build-runner:
	flutter pub run build_runner build --delete-conflicting-outputs -v