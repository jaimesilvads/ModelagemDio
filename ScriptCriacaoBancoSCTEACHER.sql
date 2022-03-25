
CREATE SCHEMA IF NOT EXISTS scteacher DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE scteacher ;

CREATE TABLE IF NOT EXISTS scteacher.usuario (
  codUsuario BIGINT NOT NULL,
  login VARCHAR(40) NULL DEFAULT NULL,
  nome VARCHAR(80) NULL DEFAULT NULL,
  senha VARCHAR(15) NULL DEFAULT NULL,
  datacad DATETIME NOT NULL,
  tipoUsuario VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (codUsuario))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


CREATE TABLE IF NOT EXISTS scteacher.alunos (
  codaluno BIGINT NOT NULL,
  nome VARCHAR(70) NULL DEFAULT NULL,
  endereco VARCHAR(45) NULL DEFAULT NULL,
  telefone VARCHAR(45) NULL DEFAULT NULL,
  email VARCHAR(45) NULL DEFAULT NULL,
  ativo VARCHAR(1) NULL DEFAULT NULL,
  codUsuario BIGINT NULL DEFAULT NULL,
  PRIMARY KEY (codaluno),
  INDEX fk_UsuarioAluno_idx (codUsuario ASC) VISIBLE,
  CONSTRAINT fk_UsuarioAluno
    FOREIGN KEY (codUsuario)
    REFERENCES scteacher.usuario (codUsuario))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS scteacher.curso (
  codCurso BIGINT NOT NULL,
  curso VARCHAR(120) NULL DEFAULT NULL,
  HorasAula INT NULL DEFAULT NULL,
  PRIMARY KEY (codCurso))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;



CREATE TABLE IF NOT EXISTS scteacher.serie (
  codSerie BIGINT NOT NULL,
  Serie VARCHAR(40) NOT NULL,
  PRIMARY KEY (codSerie))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;



CREATE TABLE IF NOT EXISTS scteacher.turma (
  codTurma BIGINT NOT NULL,
  turma VARCHAR(100) NOT NULL,
  codSerie BIGINT NOT NULL,
  codCurso BIGINT NULL DEFAULT NULL,
  PRIMARY KEY (codTurma),
  INDEX fk_serieTurma_idx (codSerie ASC) VISIBLE,
  INDEX fk_CursooTurma_idx (codCurso ASC) VISIBLE,
  CONSTRAINT fk_CursooTurma
    FOREIGN KEY (codCurso)
    REFERENCES scteacher.curso (codCurso),
  CONSTRAINT fk_SerieTurma
    FOREIGN KEY (codSerie)
    REFERENCES scteacher.serie (codSerie))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;



CREATE TABLE IF NOT EXISTS scteacher.alunos_turma (
  codTurma BIGINT NOT NULL,
  codAluno BIGINT NOT NULL,
  codTurmaAluno BIGINT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (codTurmaAluno),
  INDEX codTurma_idx (codTurma ASC) VISIBLE,
  INDEX codAluno_idx (codAluno ASC) VISIBLE,
  CONSTRAINT fk_AlunoTurma
    FOREIGN KEY (codAluno)
    REFERENCES scteacher.alunos (codaluno),
  CONSTRAINT fk_TurmaAluno
    FOREIGN KEY (codTurma)
    REFERENCES scteacher.turma (codTurma))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;



CREATE TABLE IF NOT EXISTS scteacher.disciplina (
  codDisciplina BIGINT NOT NULL,
  disciplina VARCHAR(100) NOT NULL,
  questaofim INT NOT NULL,
  questaoini INT NOT NULL,
  PRIMARY KEY (codDisciplina))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;



CREATE TABLE IF NOT EXISTS scteacher.assunto (
  codAssunto BIGINT NOT NULL,
  assunto VARCHAR(100) NOT NULL,
  questaofim INT NOT NULL,
  questaoini INT NOT NULL,
  coddisciplina BIGINT NOT NULL,
  PRIMARY KEY (codAssunto),
  INDEX FKd4cdsv7lud1b4yq4u998aeof1 (assunto ASC) VISIBLE,
  INDEX FK_AssuntDiscplina (coddisciplina ASC) VISIBLE,
  CONSTRAINT FK_AssuntDiscplina
    FOREIGN KEY (coddisciplina)
    REFERENCES scteacher.disciplina (codDisciplina))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;



CREATE TABLE IF NOT EXISTS scteacher.instituicao (
  codInstituicao BIGINT NOT NULL,
  DtCad DATE NOT NULL,
  instituicao VARCHAR(100) NOT NULL,
  responsavel VARCHAR(100) NULL DEFAULT NULL,
  telefone VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (codInstituicao))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;



CREATE TABLE IF NOT EXISTS scteacher.prova (
  codProva BIGINT NOT NULL,
  dtaplic DATETIME NOT NULL,
  qtdquestoes INT NOT NULL,
  tipoprova VARCHAR(255) NOT NULL,
  codCurso BIGINT NOT NULL,
  codInstituicao BIGINT NOT NULL,
  codTurma BIGINT NULL DEFAULT NULL,
  codUsuario BIGINT NOT NULL,
  PRIMARY KEY (codProva),
  INDEX FK_ProvaCurso (codCurso ASC) VISIBLE,
  INDEX FK_ProvaIntituicao (codInstituicao ASC) VISIBLE,
  INDEX FK_ProvaTurma (codTurma ASC) VISIBLE,
  INDEX FK_ProvaUsuario (codUsuario ASC) VISIBLE,
  CONSTRAINT FK_ProvaCurso
    FOREIGN KEY (codCurso)
    REFERENCES scteacher.curso (codCurso),
  CONSTRAINT FK_ProvaIntituicao
    FOREIGN KEY (codInstituicao)
    REFERENCES scteacher.instituicao (codInstituicao),
  CONSTRAINT FK_ProvaTurma
    FOREIGN KEY (codTurma)
    REFERENCES scteacher.turma (codTurma),
  CONSTRAINT FK_ProvaUsuario
    FOREIGN KEY (codUsuario)
    REFERENCES scteacher.usuario (codUsuario))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


CREATE TABLE IF NOT EXISTS scteacher.gabarito (
  codGabarito BIGINT NOT NULL,
  prova_codigo BIGINT NOT NULL,
  usuario_codigo BIGINT NOT NULL,
  PRIMARY KEY (codGabarito),
  INDEX FK_GabaritoProva (prova_codigo ASC) VISIBLE,
  INDEX FK_GabaritoUsuario (usuario_codigo ASC) VISIBLE,
  CONSTRAINT FK_GabaritoProva
    FOREIGN KEY (prova_codigo)
    REFERENCES scteacher.prova (codProva),
  CONSTRAINT FK_GabaritoUsuario
    FOREIGN KEY (usuario_codigo)
    REFERENCES scteacher.usuario (codUsuario))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


CREATE TABLE IF NOT EXISTS scteacher.grupos (
  codGrupo BIGINT NOT NULL,
  grupo VARCHAR(80) NULL DEFAULT NULL,
  PRIMARY KEY (codGrupo))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;



CREATE TABLE IF NOT EXISTS scteacher.questoes (
  codQuestao BIGINT NOT NULL,
  questao VARCHAR(120) NULL DEFAULT NULL,
  tipo VARCHAR(1) NULL DEFAULT NULL,
  codAssunto BIGINT NULL DEFAULT NULL,
  codDisciplina BIGINT NULL DEFAULT NULL,
  codSerie BIGINT NOT NULL,
  peso DECIMAL(2,1) NULL DEFAULT NULL,
  PRIMARY KEY (codQuestao),
  INDEX FK_QuestaoDisciplina (codDisciplina ASC) VISIBLE,
  INDEX FK_QuestaoSerie (codSerie ASC) VISIBLE,
  INDEX FK_QuestaoAssunto (codAssunto ASC) VISIBLE,
  CONSTRAINT FK_QuestaoAssunto
    FOREIGN KEY (codAssunto)
    REFERENCES scteacher.assunto (codAssunto),
  CONSTRAINT FK_QuestaoDisciplina
    FOREIGN KEY (codDisciplina)
    REFERENCES scteacher.disciplina (codDisciplina),
  CONSTRAINT FK_QuestaoSerie
    FOREIGN KEY (codSerie)
    REFERENCES scteacher.serie (codSerie))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


CREATE TABLE IF NOT EXISTS scteacher.opcao_resposta (
  ID BIGINT NOT NULL,
  codQuestao BIGINT NOT NULL,
  opcao VARCHAR(1) NULL DEFAULT NULL,
  texto VARCHAR(300) NULL DEFAULT NULL,
  PRIMARY KEY (ID),
  UNIQUE INDEX uk_opcaoresposta (codQuestao ASC, opcao ASC) VISIBLE,
  INDEX fk_QuestaoReposta_idx (codQuestao ASC) VISIBLE,
  CONSTRAINT fk_QuestaoReposta
    FOREIGN KEY (codQuestao)
    REFERENCES scteacher.questoes (codQuestao))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


CREATE TABLE IF NOT EXISTS scteacher.questoes_prova (
  id BIGINT NOT NULL,
  codProva BIGINT NULL DEFAULT NULL,
  codQuestao BIGINT NULL DEFAULT NULL,
  codAluno BIGINT NULL DEFAULT NULL,
  resposta_subjetiva VARCHAR(800) NULL DEFAULT NULL,
  resposta_objetiva VARCHAR(1) NULL DEFAULT NULL,
  PRIMARY KEY (id),
  INDEX fk_QuestaoProva_idx (codProva ASC) VISIBLE,
  INDEX fk_CodQuestao_idx (codQuestao ASC) VISIBLE,
  INDEX fk_AlunoProva_idx (codAluno ASC) VISIBLE,
  CONSTRAINT fk_AlunoProva
    FOREIGN KEY (codAluno)
    REFERENCES scteacher.alunos (codaluno),
  CONSTRAINT fk_CodQuestao
    FOREIGN KEY (codQuestao)
    REFERENCES scteacher.questoes (codQuestao),
  CONSTRAINT fk_QuestaoProva
    FOREIGN KEY (codProva)
    REFERENCES scteacher.prova (codProva))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;



CREATE TABLE IF NOT EXISTS scteacher.topicos (
  codTopico BIGINT NOT NULL,
  topico VARCHAR(80) NOT NULL,
  codassunto BIGINT NOT NULL,
  PRIMARY KEY (codTopico),
  INDEX FK_Topico_Assunto (codassunto ASC) VISIBLE,
  CONSTRAINT FK_Topico_Assunto
    FOREIGN KEY (codassunto)
    REFERENCES scteacher.assunto (codAssunto))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;



CREATE TABLE IF NOT EXISTS scteacher.usugruposacesso (
  codusuario BIGINT NOT NULL,
  codgrupo BIGINT NOT NULL,
  INDEX FKp045cgr4wcdcb0fnmb2586xpd (codgrupo ASC) VISIBLE,
  INDEX FK_Usu_GruposAcesso (codusuario ASC) VISIBLE,
  CONSTRAINT FK_Usu_GruposAcesso
    FOREIGN KEY (codusuario)
    REFERENCES scteacher.usuario (codUsuario),
  CONSTRAINT FKp045cgr4wcdcb0fnmb2586xpd
    FOREIGN KEY (codgrupo)
    REFERENCES scteacher.grupos (codGrupo))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

