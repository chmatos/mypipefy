# frozen_string_literal: true

class HomeController < ApplicationController

  def index
    default_country_id   = 224
    default_question     = 9
    show_pic_question_id = 14

    @answers = QuestionarioResposta.find_by_sql("
     SELECT  `questionario_resposta`.* FROM `questionario_resposta`
     INNER JOIN `avaliacao` ON `avaliacao`.`id` = `questionario_resposta`.`avaliacao_id`
     INNER JOIN `produto` ON `produto`.`id` = `avaliacao`.`produto_id`
     INNER JOIN `questionario_resposta` as `q`
     WHERE `q`.`avaliacao_id` = `avaliacao`.`id`
     AND `q`.`questionario_pergunta_id` = #{show_pic_question_id}
     AND `q`.`resposta` = 1
     AND `avaliacao`.`status` = 'A'
     AND `produto`.`country_id` = #{default_country_id}
     AND `questionario_resposta`.`questionario_pergunta_id` = #{default_question}
     ORDER BY rand()
     LIMIT 3
   ")
  end

  def terms_and_conditions
  end
end
