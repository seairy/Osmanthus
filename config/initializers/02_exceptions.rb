exceptions = %w(
  PermissionDenied
  InvalidState
  ParameterIsBlank
  ParameterIsEmpty
  CountryIsEmpty
  InvalidAcceptablePrice
  InvalidActualPrice
  UnacceptablePrice
  InvalidActualPriceCurrency
  DifferentCurrency
)
exceptions.each{|e| Object.const_set(e, Class.new(StandardError))} 