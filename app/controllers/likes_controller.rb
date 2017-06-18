class LikesController < ApplicationController
  before_action :set_like, only: [:show, :edit, :update, :destroy]

  # GET /likes
  # GET /likes.json
  def index
    @likes = Like.all
  end

  # GET /likes/1
  # GET /likes/1.json
  def show
  end

  # GET /likes/new
  def new
    @like = Like.new
  end

  # GET /likes/1/edit
  def edit
  end

  # def addLike
  #   document_id = params[:document_id]
  #   @like = Like.new
  #   @like.document_id = document_id
  #   @like.person_id = current_person.id
  #   @like.save
  #   jsonObj = {"likingPeople" => getLikingPeople(document_id).length}
  #   respond_to do |format|
  #     format.html
  #     format.json { render json: jsonObj }
  #   end
  # end
  #
  # def getLikingPeople(document_id)
  #   @document = Document.find(document_id)
  #   @likes = @document.likes
  #   return @likes
  # end
  #
  # def removeLike
  #   document_id = params[:document_id]
  #   @like = current_person.likes.where('document_id = ?', "#{document_id}").first
  #   Like.destroy(@like.id)
  #   jsonObj = {"likingPeople" => getInterestedPeople(document_id).length}
  #   respond_to do |format|
  #     format.html
  #     format.json { render json: jsonObj }
  #   end
  # end

  # POST /likes
  # POST /likes.json
  def create
    @like = Like.new(like_params)

    respond_to do |format|
      if @like.save
        format.html { redirect_to @like, notice: 'Like was successfully created.' }
        format.json { render :show, status: :created, location: @like }
      else
        format.html { render :new }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /likes/1
  # PATCH/PUT /likes/1.json
  def update
    respond_to do |format|
      if @like.update(like_params)
        format.html { redirect_to @like, notice: 'Like was successfully updated.' }
        format.json { render :show, status: :ok, location: @like }
      else
        format.html { render :edit }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /likes/1
  # DELETE /likes/1.json
  def destroy
    @like.destroy
    respond_to do |format|
      format.html { redirect_to likes_url, notice: 'Like was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def like_params
      params.require(:like).permit(:person_id, :document_id)
    end
end
