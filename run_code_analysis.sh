# - Install the following (assuming that homebrew is installed prior):
# Python3 -> brew install python3
# Pip -> sudo easy_install pip
# remove_from_coverage -> pub global activate remove_from_coverage
# lcov to cobertura -> pip3 install git+https://github.com/eriwen/lcov-to-cobertura-xml.git
# pycobertura -> pip3 install pycobertura

# - Setup the following paths to /etc/paths (via 'sudo nano/etc/paths') before use:
# Exact path of Flutter SDK (eg. ../flutter/bin)
# Exact path of Dart SDK (eg. ../flutter/bin/cache/dart-sdk/bin)
# Exact path of pubcache (eg. ../.pub-cache/bin)
# Exact path of Pip (eg. ../Library/Python/2.7/lib/python/site-packages)

#show-code-coverage:
	rm -f flutter-coverage.html flutter-coverage.xml flutter-lcov.info test/coverage_test.dart

	curl -O https://raw.githubusercontent.com/priezz/dart_full_coverage/master/dart-coverage-helper

	sh dart-coverage-helper

	flutter test --coverage --coverage-path=flutter-lcov.info

	remove_from_coverage -f flutter-lcov.info -r ".g.dart$","main.dart"

	lcov_cobertura flutter-lcov.info --output flutter-coverage.xml

	pycobertura show --format html --output flutter-coverage.html flutter-coverage.xml

	open flutter-coverage.html
	
#analyze:
	flutter analyze --fatal-infos --fatal-warnings .

	rm -f test/coverage_test.dart