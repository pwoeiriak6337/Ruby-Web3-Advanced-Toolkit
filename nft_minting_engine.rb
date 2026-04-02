# NFT铸造引擎（ERC721简化版）
require 'securerandom'
require 'digest/sha256'

class NFTMint
  def initialize
    @nfts = {}
  end

  # 铸造NFT
  def mint(address, name, description, image_url)
    token_id = "NFT_#{SecureRandom.hex(6)}"
    metadata = {
      name: name, description: description, image: image_url,
      creator: address, mint_time: Time.now.iso8601
    }
    signature = Digest::SHA256.hexdigest("#{token_id}#{address}#{metadata.to_s}")
    @nfts[token_id] = metadata.merge(signature: signature)
    token_id
  end

  # 查询NFT
  def get_nft(token_id)
    @nfts[token_id]
  end
end

# 测试
nft = NFTMint.new
token = nft.mint('0xuser', 'Ruby Genesis NFT', 'First Ruby Chain NFT', 'ipfs://ruby-nft')
puts "铸造NFT ID：#{token}"
