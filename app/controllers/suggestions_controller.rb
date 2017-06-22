class SuggestionsController < ApplicationController
  before_action :set_suggestion, only: [:show, :edit, :update, :destroy]
  before_action :set_document

  # GET /suggestions
  # GET /suggestions.json
  def index
    @suggestions = Suggestion.all
    if params[:search]
      @suggestions = Suggestion.all.search(params[:search]).order("created_at DESC")
    else
      @suggestions = Suggestion.all.order("created_at DESC")
    end

  end

  # GET /suggestions/1
  # GET /suggestions/1.json
  def show
    @comments = Comment.where("suggestion_id = ?", @suggestion.id)
  end

  # GET /suggestions/new
  def new
    @suggestion = Suggestion.new
  end

  # GET /suggestions/1/edit
  def edit
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
    @suggestion.destroy
    respond_to do |format|
      format.html { redirect_to suggestions_url, notice: 'Suggestion was successfully destroyed.' }
      format.json { head :no_content }
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