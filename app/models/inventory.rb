class Inventory
    def total(id)
        url = 'https://www.lcbapps.lcb.state.pa.us/webapp/Product_Management/psi_ProductInventory_Inter.asp?cdeNo=' + id
        response = HTTParty.get(url)
        html_doc = Nokogiri::HTML(response)
        return totalStores = html_doc.xpath("//table[2]/tr[2]/td[1]/table/tr[1]/td/font").text.strip.scan(/\d+/).first
    end

    def stocks(id)
        total = self.total(id).to_i
        offset = 0
        results = []
        while offset < total
            offset += 10
            url = "https://www.lcbapps.lcb.state.pa.us/webapp/Product_Management/psi_ProductInventory_Inter.asp?cdeNo=" + id + '&offset=' + offset.to_s
            html = HTTParty.get(url);
            html_doc = Nokogiri::HTML(html)

            stocks = html_doc.xpath('//table[3]/tr')
            stocks.each_with_index do |stock, index| 
                    puts store = stock.xpath('td')[0].text.strip if stock.xpath('td')[0]
                    address = stock.xpath('td')[1].to_s.strip.match(/\<br\>([\sA-Z]+),\s[A-Z]{2},\s/).to_s.strip.split(',')[0] if stock.xpath('td')[1]
                    puts address = address[4,  address.length-4] if address
                    puts stock = stock.xpath('td[last()]').text.match(/\d+/) if stock.xpath('td[last()]')

                    if store && stock
                        result = Hash.new
                        result[:store] = store
                        result[:address] = address
                        result[:stock] = stock.to_s
                        results << result
                    end
            end

        end
        return results
    end
end