class EnvConfig {
  static const tmdbApiKeyV3 = String.fromEnvironment(
    'tmdbApiKeyV3',
    defaultValue: '0dd3695069cc84656efd13aa14613534',
  );

  static const tmdbApiReadKeyV4 = String.fromEnvironment(
    'tmdbApiReadKeyV4',
    defaultValue:
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwZGQzNjk1MDY5Y2M4NDY1NmVmZDEzYWExNDYxMzUzNCIsInN1YiI6IjYwNTZkMTQwZmQ0ZjgwMDA1NDI0MzY4MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.-v1ifkVCE8E-BWg-8lBMx4iU6RCbFouN9zJU9tlvLEQ',
  );

  static const tmdbApiImageEndpoint = String.fromEnvironment(
      'tmdbApiImageEndpoint',
      defaultValue: 'https://image.tmdb.org/t/p');

  static const placeholderEndpoint = String.fromEnvironment(
      'placeholderEndpoint',
      defaultValue: 'https://via.placeholder.com');
}
