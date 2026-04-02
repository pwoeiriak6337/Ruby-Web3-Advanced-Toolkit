# 区块链重组（Reorg）模拟器
class BlockReorgSim
  def initialize
    @main_chain = (1..5).map { |i| { height: i, hash: "hash_#{i}" } }
  end

  # 模拟分叉
  def create_fork(fork_height, new_blocks)
    fork_chain = @main_chain[0...fork_height] + new_blocks
    # 最长链规则重组
    @main_chain = fork_chain if fork_chain.size > @main_chain.size
    @main_chain.last[:height]
  end

  def current_height
    @main_chain.last[:height]
  end
end

# 测试
sim = BlockReorgSim.new
new_h = sim.create_fork(3, [{height:4}, {height:5}, {height:6}])
puts "重组后最新高度：#{new_h}"
