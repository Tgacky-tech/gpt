require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models/count.rb'
require "openai"
$client = OpenAI::Client.new(access_token: "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")



get '/' do
  response = $client.chat(
    parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: "こんにちは" }],
    })
    @res = "なぞなぞのテーマを教えてください。それをもとに四択の問題を出題します"
    erb :index
end


post '/talk' do
    if params[:keyword].empty? == false
        question = params[:keyword]
         response = $client.chat(
        parameters: {
            model: "gpt-3.5-turbo",
            messages: [
                { role: "user", content: "テーマを入力するので、それを元に一つのなぞなぞと四つの選択肢を作ってください。その時に次に指定する形式に従ってください。Q.問題 A.答え 1.選択肢一つ目 ２.選択肢二つ目 ３.選択肢三つ目 ４.選択肢四つ目 解説" },
                { role: "user", content: question },
                       ],
        })
    else
        question = "自己紹介して"
        response = $client.chat(
    parameters: {
        model: "gpt-3.5-turbo",
        messages: [
            { role: "user", content: question },
                   ],
    })
    end
    @res = response.dig("choices", 0, "message", "content")
    @allay = @res.split
    if @allay.length <= 11
    @question = @allay[0]
    @choice1 = @allay[2]
    @choice2 = @allay[3]
    @choice3 = @allay[4]
    @choice4 = @allay[5]
    @answer  = @allay[1]
    @kaisetu = @allay[-1]
    else
    @question = @allay[0] + @allay[1]
    @choice1 = @allay[4] + @allay[5]
    @choice2 = @allay[6] + @allay[7]
    @choice3 = @allay[8] + @allay[9]
    @choice4 = @allay[10] + @allay[11]
    @answer  = @allay[2] + @allay[3]
    @kaisetu = @allay[-1]
    end
    erb :key
end

post '/talk/result' do
    puts params[:raradio]
    puts params[:radio003]
    
  if params[:raradio] == params[:radio003]
      @result = "正解！"
      @answer = params[:raradio]
  else
      @result = "不正解"
      @answer = params[:raradio]
  end
      @kaisetu = params[:kaisetu]
  erb :keytrue
end

get '/number' do
  @res = "答えの文字数を教えてください。それをもとに四択の問題を出題します。"
  erb :number
end

post '/number' do
    if params[:number].empty? == false
        question = params[:number]
         response = $client.chat(
        parameters: {
            model: "gpt-3.5-turbo",
            messages: [
                # { role: "user", content: "答えと選択肢の単語が何文字かを指定するので、それを元に一つのなぞなぞと四つの選択肢を作ってください。その時に必ず次に指定する形式に従ってください。Q.問題 A.答え 1.選択肢一つ目 ２.選択肢二つ目 ３.選択肢三つ目 ４.選択肢四つ目" },
                # { role: "user", content: question },
                { role: "user", content: "選択肢が" + question + "文字の一つのなぞなぞと四つの選択肢を作ってください。その時に必ず次に指定する形式に従ってください。Q.問題 A.答え 1.選択肢一つ目 ２.選択肢二つ目 ３.選択肢三つ目 ４.選択肢四つ目" },
                       ],
        })
    else
        question = "自己紹介して"
        response = $client.chat(
    parameters: {
        model: "gpt-3.5-turbo",
        messages: [
            { role: "user", content: question },
                   ],
    })
    end
    @res = response.dig("choices", 0, "message", "content")
    @allay = @res.split
    if @allay.length == 6
    @question = @allay[0]
    @choice1 = @allay[2]
    @choice2 = @allay[3]
    @choice3 = @allay[4]
    @choice4 = @allay[5]
    @answer  = @allay[1]
    else
    @question = @allay[0] + @allay[1]
    @choice1 = @allay[4] + @allay[5]
    @choice2 = @allay[6] + @allay[7]
    @choice3 = @allay[8] + @allay[9]
    @choice4 = @allay[10] + @allay[11]
    @answer  = @allay[2] + @allay[3]
    end
    erb :numberquestion
end

get '/random' do
  @res = "下のボタンを押すと、chat-GPTがランダムになぞなぞを作成します。"
  erb :random
end

post '/random' do
    if params[:random].empty? == false
        question = params[:random]
         response = $client.chat(
        parameters: {
            model: "gpt-3.5-turbo",
            messages: [
                { role: "user", content: "ランダムに難しい一つのなぞなぞと四つの選択肢を作ってください。その時に次に指定する形式に従ってください。Q.問題 A.答え 1.選択肢一つ目 ２.選択肢二つ目 ３.選択肢三つ目 ４.選択肢四つ目 解説" },
                { role: "user", content: question },
                       ],
        })
    else
        question = "自己紹介して"
        response = $client.chat(
    parameters: {
        model: "gpt-3.5-turbo",
        messages: [
            { role: "user", content: question },
                   ],
    })
    end
    @res = response.dig("choices", 0, "message", "content")
    @allay = @res.split
    puts @allay
    puts @allay.length
    if @allay.length <= 9
    @question = @allay[0]
    @choice1 = @allay[2]
    @choice2 = @allay[3]
    @choice3 = @allay[4]
    @choice4 = @allay[5]
    @answer  = @allay[1]
    @kaisetu = @allay[-1]
    else
    @question = @allay[0] + @allay[1]
    @choice1 = @allay[4] + @allay[5]
    @choice2 = @allay[6] + @allay[7]
    @choice3 = @allay[8] + @allay[9]
    @choice4 = @allay[10] + @allay[11]
    @answer  = @allay[2] + @allay[3]
    @kaisetu = @allay[-1]
    end
    erb :randomquestion
end

post '/number/result' do
    puts params[:raradio]
    puts params[:radio003]
    
  if params[:raradio] == params[:radio003]
      @result = "正解！"
      @answer = params[:raradio]
  else
      @result = "不正解"
      @answer = params[:raradio]
  end
      @kaisetu = params[:kaisetu]
  erb :randomtrue
end