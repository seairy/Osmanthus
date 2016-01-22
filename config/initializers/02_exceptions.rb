exceptions = %w(
  PermissionDenied
  InvalidState
  ParameterIsBlank
  ParameterIsEmpty
  CountryIsEmpty
  InvalidAcceptablePrice
)
exceptions.each{|e| Object.const_set(e, Class.new(StandardError))} 