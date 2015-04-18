module Lita
  module Handlers
    class Dictionary < Handler
      route %r{j2e}, :translate_jp2en, command: true, help: {
        "j2e" => "Translate a japanese word to english"}
      
      def translate_jp2en(response)
        word_jp = response.message.body.split(' ')[1]
        itemid = dejizoitem(word_jp)
        word_en = dejizoresult(itemid)
        response.reply(word_jp + " は *" + word_en + "* ですよ。")
      end
      
      def dejizoitem(word)
        enc_word = URI.encode(word)
        url = "http://public.dejizo.jp/NetDicV09.asmx/SearchDicItemLite?Dic=EdictJE&Word=#{enc_word}&Scope=HEADWORD&Match=STARTWITH&Merge=OR&Prof=&PageSize=3&PageIndex=0"
        xml = open(url).read
        doc = Nokogiri::XML(xml)
        itemid = doc.search('ItemID').first.inner_text rescue nil
      end
      
      def dejizoresult(itemid)
        url = "http://public.dejizo.jp/NetDicV09.asmx/GetDicItemLite?Dic=EdictJE&Item=#{itemid}&Loc=&Prof=XHTML"
        xml = open(url).read
        doc = Nokogiri::XML(xml)
        result = []
        doc.xpath('//div[@class="NetDicBody"]/div/div').each do |div| 
          result.push(div.text)
        end
        word = result[0]  # 一行目が単語の見出し
        return word.match(/\(.*\) (.*)/)[1]  # "(n) (uk) apple"みたいな形式で返ってくる
      end
    end

    Lita.register_handler(Dictionary)
  end
end
