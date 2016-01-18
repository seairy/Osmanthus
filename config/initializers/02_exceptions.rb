exceptions = %w(
  PermissionDenied
  InvalidState
  ParameterIsBlank
  ParameterIsEmpty
  CountryIsEmpty
)
exceptions.each{|e| Object.const_set(e, Class.new(StandardError))} 