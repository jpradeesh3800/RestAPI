class BooksController < ApplicationController

    def show
        if params.has_key?(:id)
            if Book.exists?(id: params[:id])
                book = Book.find(params[:id]);
                render json: {status: "SUCCESS", message:"Read one book", data:book},status: :ok
            else
                render json: {status: "ERROR", message:"Book not found"},status: :ok
            end
        else
            books = Book.order("created_at DESC");
            render json: {status: "SUCCESS", message:"Reading all Books", data:books},status: :ok
        end
    end
  
    def create
        book = Book.new(books_params)

        # if Book.exists?(B_title: books_params[:B_title],Author: books_params[:Author],Publisher: books_params[:Publisher],Year: books_param[:Year])
        if Book.exists?(books_params)
            render json: {status: "ERROR", message:"Book already created"},status: :ok
        else
            if book.save
                render json: {status: "SUCCESS", message:"Book created", data:book},status: :ok
            else
                render json: {status: "ERROR", message:"Book not created", data:book.errors},status: :unprocessable_entity
            end
        end
    end

    def destroy
        if Book.exists?(id: params[:id])
            book = Book.find(params[:id])
            if book.destroy
                render json: {status: "SUCCESS", message:"Book deleted", data:book},status: :ok
            else
                render json: {status: "ERROR", message:"Book not deleted", data:book.errors},status: :unprocessable_entity
            end
        else
            render json: {status: "ERROR", message:"Book not found"},status: :ok
        end
    end

    def update
        if Book.exists?(id: params[:id])
            book = Book.find(params[:id])
            if book.update(books_params)
                render json: {status: "SUCCESS", message:"Book updated", data:book},status: :ok
            else
                render json: {status: "ERROR", message:"Book not updated", data:book.errors},status: :unprocessable_entity
            end
        else
            render json: {status: "ERROR", message:"Book not found"},status: :ok
        end

    end

    private

    def books_params
        params.permit(:B_title,:Author,:Publisher,:Year)
    end
end
