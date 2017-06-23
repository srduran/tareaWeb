class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy, :show_enrollments]
  skip_before_action :authenticate_person!, :only => [:index, :show], raise: false


  # GET /documents
  # GET /documents.json
  def index
    if !person_signed_in?
      @documents = Document.where("public = ?", true)
      if params[:search]
        @documents = Document.where("public  = ?", true).search(params[:search]).order("created_at DESC")
      else
        @documents = Document.where("public  = ?", true).order("created_at DESC")
      end
    else
      @documents = Document.all
      if params[:search]
        @documents = Document.search(params[:search]).order("created_at DESC")
      else
        @documents = Document.all.order("created_at DESC")
      end
    end
    @show_enrollments = Enrollment.all
  end

  # GET /documents/1
  # GET /documents/1.json
  def my_documents

    @authors = Author.where("person_id = ?", current_person.id)
    @documents = []
    @authors.each do |author|
      @documents.append (Document.find(author.document_id))
    end

    @show_enrollments = Enrollment.all
  end

  def show
    @is_author = Author.where("person_id = ? AND document_id = ?", current_person.id, @document.id).present?

    if @is_author
      @author = Author.new

      @authors = Author.where("document_id = ?", @document.id)
      @not_authors = Person.all
      @authors.each do |author|
        @not_authors = @not_authors.to_a - [Person.find(author.person_id)]
      end
    end
    if !@document.public and !person_signed_in?
      redirect_to documents_path, alert: "No permissions"
    else
      @show_enrollments = Enrollment.where("document_id = ?", params[:id])
    end
  end

  # GET /documents/new
  def new
    @document = Document.new
    @show_enrollments = Enrollment.none
  end

  # GET /documents/1/edit
  def edit
    @is_author = Author.where("person_id = ? AND document_id = ?", current_person.id, @document.id).present?

    if !@is_author
      redirect_to documents_url, notice: 'You can not edit if you are not author'
    else
    # if @document.save
    #   @category = Category.where("categories_id=?", current_category.id)
    # end
      @show_enrollments = Enrollment.where("document_id = ?", params[:id])
    end
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)

    respond_to do |format|
      if @document.save
        Enrollment.create(:category_id => @document.categories_id, :document_id => @document.id)
        Author.create(:document_id => @document.id, :person_id => current_person.id)
        format.html { redirect_to @document, notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @is_author = Author.where("person_id = ? AND document_id = ?", current_person.id, @document.id).present?

    if !@is_author
      redirect_to documents_url, notice: 'You can not destroy if you are not author'
    else
      Author.where("document_id = ?", @document.id).first().destroy
      Enrollment.where("document_id =?", @document.id).first().destroy
      @document.destroy
      respond_to do |format|
        format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:title, :text, :categories_id, :public)
    end
end
