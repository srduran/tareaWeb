class SuggestionsController < ApplicationController
  before_action :set_suggestion, only: [:show, :edit, :update, :destroy]
  before_action :set_document
  before_action :check_author

  # GET /suggestions
  # GET /suggestions.json

  def check_author
    @is_author = Author.where("person_id = ? AND document_id = ?", current_person.id, @document.id).present?
  end

  def index
    @suggestions = Suggestion.where("document_id = ?", @document.id)
    if params[:searchStatus]
      @suggestions = Suggestion.where("document_id = ?", @document.id).searchStatus(params[:searchStatus]).order("created_at DESC")
    else
      @suggestions = Suggestion.where("document_id = ?", @document.id).order("created_at DESC")
    end

  end

  # GET /suggestions/1
  # GET /suggestions/1.json
  def show
    if @is_author
      @author = Author.new
    end
    @comments = Comment.where("suggestion_id = ?", @suggestion.id)
  end

  # GET /suggestions/new
  def new
    @suggestion = Suggestion.new
  end

  # GET /suggestions/1/edit
  def edit
    if !@is_author
      redirect_to document_suggestions_url, notice: 'You can not edit if you are not author'
    end
  end

  # POST /suggestions
  # POST /suggestions.json
  def create
    @suggestion = Suggestion.new(suggestion_params)
    @suggestion.person_id = current_person.id

    respond_to do |format|
      if @suggestion.save
        format.html { redirect_to [@document, @suggestion], notice: 'Suggestion was successfully created.' }
        format.json { render :show, status: :created, location: @suggestion }
      else
        format.html { render :new }
        format.json { render json: @suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /suggestions/1
  # PATCH/PUT /suggestions/1.json
  def update
    respond_to do |format|
      if @suggestion.update(suggestion_params)
        format.html { redirect_to [@document, @suggestion], notice: 'Suggestion was successfully updated.' }
        format.json { render :show, status: :ok, location: @suggestion }
      else
        format.html { render :edit }
        format.json { render json: @suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /suggestions/1
  # DELETE /suggestions/1.json
  def destroy
    if !@is_author
      redirect_to document_suggestions_url, notice: 'You can not destroy if you are not author'
    else
     @suggestion.destroy
     respond_to do |format|
       format.html { redirect_to document_suggestions_url, notice: 'Suggestion was successfully destroyed.' }
       format.json { head :no_content }
     end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_suggestion
      @suggestion = Suggestion.find(params[:id])
    end

    def set_document
      if @suggestion and @suggestion.document_id
        @document = @suggestion.document
      end
      @document = Document.find(params[:document_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def suggestion_params
      params.require(:suggestion).permit(:document_id, :text, :status, :person_id)
    end
end
