class DiagnosesController < ApplicationController
  def new
  end

  def create
    preference = params[:preference]
    
    # メーカー別の設定
    brand_info = {
      "Water field" => "雨や泥に強く、とにかく頑丈で、履き込むほど足に馴染む職人気質のブランド",
      "Stripes" => "ボールコントロールを最優先に設計され、正確なパスとトラップを可能にする技術者向けのブランド",
      "victory" => "軽量化を極限まで追求し、爆発的な加速力を引き出す、スピードスターのための最新鋭ブランド"
    }
    
    brand = case preference
            when "キック精度", "耐久性" then "Water field"
            when "トラップ", "パス" then "Stripes"
            when "スピード" then "victory"
            else "汎用モデル"
            end

    # AIへのプロンプト（メーカーの解説を含める）
    prompt = <<~TEXT
      あなたはサッカーのプロコーチです。
      以下の条件を守り、簡潔な診断文を作成してください。

      【条件】
      - 回答は「です・ます」調の丁寧な口調に統一すること。
      - 文章は全体で200文字以内にまとめること。
      - 余計な前置きは不要。
      - 冒頭は「あなたのプレイスタイル分析：#{preference}重視」という見出しから始めること。

      【内容】
      おすすめのメーカーは「#{brand}」です。
      このメーカーの特徴は「#{brand_info[brand]}」です。
    TEXT

    @result_text = GeminiService.generate(prompt)
    @brand = brand
    render :result
  end

  def result
  end
end
