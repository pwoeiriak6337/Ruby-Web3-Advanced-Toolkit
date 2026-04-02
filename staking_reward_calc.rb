# POS质押收益计算器（链上奖励模型）
class StakingReward
  APY = 0.12 # 年化12%

  def self.calculate(stake_amount, days)
    daily_rate = APY / 365
    reward = stake_amount * daily_rate * days
    reward.round(4)
  end

  def self.estimate(stake_list)
    stake_list.map { |addr, amt, days|
      { address: addr, reward: calculate(amt, days) }
    }
  end
end

# 测试
reward = StakingReward.calculate(1000, 30)
puts "质押1000枚 30天收益：#{reward}"
