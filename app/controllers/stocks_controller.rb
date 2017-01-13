class StocksController < ApplicationController
    def total()
        inventory = ::Inventory.new
        total = inventory.total(params[:id])
        render json: total
    end
    
    def stocks()
        inventory = ::Inventory.new
        results = inventory.stocks(params[:id])
        render json: results
    end
    

end
