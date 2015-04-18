module Lita
  module Handlers
    class Dictionary < Handler
      route %r{j2e}, :translate_jp2en, command: true, help: {
        "j2e" => "Translate a japanese word to english"}
      
      def translate_jp2en(response)
        response.reply("Apple")
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
        text = doc.search('Body').inner_text rescue nil
        text.gsub!(/(\r\n|\r|\n|\t|\s)/, '')
      end

    end

    Lita.register_handler(Dictionary)
  end
end
