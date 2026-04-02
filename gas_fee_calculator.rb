# Gas费计算引擎（以太坊EVM风格）
class GasFeeCalculator
  BASE_GAS = 21000
  TX_GAS = { transfer: 10000, contract: 50000, deploy: 100000 }

  def self.calculate(gas_price, tx_type = :transfer)
    total_gas = BASE_GAS + TX_GAS[tx_type]
    total_fee = (total_gas * gas_price).round(6)
    { gas_used: total_gas, gas_price: gas_price, total_fee: total_fee }
  end
end

# 测试
fee = GasFeeCalculator.calculate(0.0000001, :transfer)
puts "Gas费：#{fee[:total_fee]}"
