require 'net/http'
require 'uri'
require 'json'

class GeminiService
  def self.generate(prompt)
    # ここで環境変数からAPIキーを読み込みます
    api_key = ENV['GEMINI_API_KEY']
    return "APIキーが設定されていません" if api_key.blank?
    
    # モデル名を最新の v1beta パスに合わせます
    uri = URI.parse("https://generativelanguage.googleapis.com/v1beta/models/gemini-3-flash-preview:generateContent?key=#{api_key}")
    
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    
    request = Net::HTTP::Post.new(uri.request_uri)
    request["Content-Type"] = "application/json"
    request.body = {
      contents: [{ role: "user", parts: [{ text: prompt }] }]
    }.to_json
        
    response = http.request(request)
    puts "----------------------------"
    puts "HTTP Status: #{response.code}"
    puts "Response Body: #{response.body}"
    puts "----------------------------"
    result = JSON.parse(response.body)
    
    # 結果の取得
    if result["candidates"] && result.dig("candidates", 0, "content", "parts", 0, "text")
      result.dig("candidates", 0, "content", "parts", 0, "text")
    else
      "診断結果を取得できませんでした。エラー詳細: #{result.dig('error', 'message') || '不明なエラー'}"
    end
  end
end