# app/controllers/categories_controller.rb
class CategoriesController < ApplicationController
    before_action :set_category, only: [:show, :otc, :prescription, :branded, :generic]
  
    def index
        @products = Product.page(params[:page]).per(10)
      end
    
      def show
        @products = @category.products.page(params[:page]).per(10)
      end
    
      def otc
        @category = Category.find_or_create_by(name: 'OTC')
        @products = @category.products.page(params[:page]).per(10)
        render 'show'
      end
      
    
      def prescription
        @category = Category.find_or_create_by(name: 'Prescription')
        @products = @category.products.page(params[:page]).per(10)
        render 'show'
      end
      
    
      def branded
        @category = Category.find_or_create_by(name: 'Branded')
        @products = @category.products.page(params[:page]).per(10)
        render 'show'
      end
    
      def generic
        @category = Category.find_or_create_by(name: 'Generic')
        @products = @category.products.page(params[:page]).per(10)
        render 'show'
      end
    
      private
    
      def set_category
        @category = Category.find_by(name: params[:id])
      end
    end