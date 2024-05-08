-- Verifica se a tabela Estudante já existe antes de criar
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Estudante')
BEGIN
    CREATE TABLE Estudante (
        idEstudante INT PRIMARY KEY,
        TelefoneEstudante VARCHAR(20),
        CelularEstudante VARCHAR(20),
        EmailEstudante VARCHAR(100)
    );
    PRINT 'Tabela Estudante criada com êxito.';
END
ELSE
BEGIN
    PRINT 'A tabela Estudante já foi criada.';
END;

-- Verifica se a tabela Localizacao já existe antes de criar
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Localizacao')
BEGIN
    CREATE TABLE Localizacao (
        idLocalizacao INT PRIMARY KEY,
        Cidade VARCHAR(100),
        Rua VARCHAR(100),
        EmailLocalizacao VARCHAR(100)
    );
    PRINT 'Tabela Localizacao criada com sucesso.';
END
ELSE
BEGIN
    PRINT 'A tabela Localizacao já está presente.';
END;

-- Verifica se a tabela EstudanteLocalizacao já existe antes de criar
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'EstudanteLocalizacao')
BEGIN
    CREATE TABLE EstudanteLocalizacao (
        idEstudante INT,
        idLocalizacao INT,
        PRIMARY KEY (idEstudante, idLocalizacao),
        FOREIGN KEY (idEstudante) REFERENCES Estudante(idEstudante),
        FOREIGN KEY (idLocalizacao) REFERENCES Localizacao(idLocalizacao)
    );
    PRINT 'Tabela EstudanteLocalizacao criada com êxito.';
END
ELSE
BEGIN
    PRINT 'A tabela EstudanteLocalizacao já existe.';
END;

-- Verifica se a tabela PessoaFisica já existe antes de criar
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PessoaFisica')
BEGIN
    CREATE TABLE PessoaFisica (
        idPessoaFisica INT PRIMARY KEY,
        nomeCompleto VARCHAR(100),
        documentoIdentidade VARCHAR(14),
        idade INT,
        idLocalizacao INT,
        idEstudante INT,
        FOREIGN KEY (idLocalizacao) REFERENCES Localizacao(idLocalizacao),
        FOREIGN KEY (idEstudante) REFERENCES Estudante(idEstudante)
    );
    PRINT 'Tabela PessoaFisica criada com sucesso.';
END
ELSE
BEGIN
    PRINT 'A tabela PessoaFisica já foi criada.';
END;

-- Verifica se a tabela Graduacao já existe antes de criar
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Graduacao')
BEGIN
    CREATE TABLE Graduacao (
        idGraduacao INT PRIMARY KEY,
        idPessoaFisica INT,
        ativo BOOLEAN,
        FOREIGN KEY (idPessoaFisica) REFERENCES PessoaFisica(idPessoaFisica)
    );
    PRINT 'Tabela Graduacao criada com sucesso.';
END
ELSE
BEGIN
    PRINT 'A tabela Graduacao já existe.';
END;

-- Verifica se a tabela SetorAcademico já existe antes de criar
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'SetorAcademico')
BEGIN
    CREATE TABLE SetorAcademico (
        NomeSetorAcademico VARCHAR(100) PRIMARY KEY,
        Numero INT,
        CoordenadorSetorAcademico VARCHAR(100)
    );
    PRINT 'Tabela SetorAcademico criada com sucesso.';
END
ELSE
BEGIN
    PRINT 'A tabela SetorAcademico já foi criada.';
END;

-- Verifica se a tabela ProgramaAcademico já existe antes de criar
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ProgramaAcademico')
BEGIN
    CREATE TABLE ProgramaAcademico (
        nomeProgramaAcademico VARCHAR(100) PRIMARY KEY,
        NomeSetorAcademico VARCHAR(100),
        FOREIGN KEY (NomeSetorAcademico) REFERENCES SetorAcademico(NomeSetorAcademico)
    );
    PRINT 'Tabela ProgramaAcademico criada com êxito.';
END
ELSE
BEGIN
    PRINT 'A tabela ProgramaAcademico já está presente.';
END;

-- Verifica se a tabela DisciplinaEstudo já existe antes de criar
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DisciplinaEstudo')
BEGIN
    CREATE TABLE DisciplinaEstudo (
        idDisciplinaEstudo INT PRIMARY KEY,
        nomeDisciplinaEstudo VARCHAR(100),
        disciplinaEstudoPrograma VARCHAR(100)
    );
    PRINT 'Tabela DisciplinaEstudo criada com sucesso.';
END
ELSE
BEGIN
    PRINT 'A tabela DisciplinaEstudo já foi criada.';
END;

-- Verifica se a tabela DisciplinaProgramaAcademico já existe antes de criar
IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DisciplinaProgramaAcademico')
BEGIN
    CREATE TABLE DisciplinaProgramaAcademico (
        idDisciplinaEstudo INT,
        nomeProgramaAcademico VARCHAR(100),
        PRIMARY KEY (idDisciplinaEstudo, nomeProgramaAcademico),
        FOREIGN KEY (idDisciplinaEstudo) REFERENCES DisciplinaEstudo(idDisciplinaEstudo),
        FOREIGN KEY (nomeProgramaAcademico) REFERENCES ProgramaAcademico(nomeProgramaAcademico)
    );
    PRINT 'Tabela DisciplinaProgramaAcademico criada com sucesso.';
END
ELSE
BEGIN
    PRINT 'A tabela DisciplinaProgramaAcademico já existe.';
END;

-- Comandos DML (Data Manipulation Language)

-- Nenhum comando DML necessário nesta etapa de conceituação.

-- Comandos DQL (Data Query Language) com Provas de Conceito

-- Exemplo de consulta: Dado o CPF ou o Nome do Estudante, buscar no BD todos os demais dados do estudante.
-- Query:
SELECT * FROM PessoaFisica WHERE nomeCompleto = 'Nome do Estudante' OR CPF = 'CPF do Estudante';
-- Prova de Conceito:
-- Retorna todos os dados da pessoa física cujo nome é 'Nome do Estudante' ou cujo CPF é 'CPF do Estudante'.

-- Exemplo de consulta: Dado o nome de um setor acadêmico, exibir o nome de todos os programas acadêmicos associados a ele.
-- Query:
SELECT nomeProgramaAcademico FROM ProgramaAcademico WHERE NomeSetorAcademico = 'Nome do Setor Acadêmico';
-- Prova de Conceito:
-- Retorna o nome de todos os programas acadêmicos associados ao setor acadêmico cujo nome é 'Nome do Setor Acadêmico'.

-- Exemplo de consulta: Dado o nome de uma disciplina de estudo, exibir a qual ou quais programas acadêmicos ela pertence.
-- Query:
SELECT nomeProgramaAcademico FROM DisciplinaProgramaAcademico WHERE idDisciplinaEstudo = (SELECT idDisciplinaEstudo FROM DisciplinaEstudo WHERE nomeDisciplinaEstudo = 'Nome da Disciplina de Estudo');
-- Prova de Conceito:
-- Retorna o nome do programa acadêmico ou programas acadêmicos aos quais a disciplina de estudo cujo nome é 'Nome da Disciplina de Estudo' pertence.

-- Exemplo de consulta: Dado o CPF de um estudante, exibir quais disciplinas de estudo ele está cursando.
-- Query:
SELECT nomeDisciplinaEstudo FROM DisciplinaEstudo WHERE idDisciplinaEstudo IN (SELECT idDisciplinaEstudo FROM DisciplinaProgramaAcademico WHERE nomeProgramaAcademico IN (SELECT nomeProgramaAcademico FROM ProgramaAcademico WHERE idPessoaFisica = (SELECT idPessoaFisica FROM PessoaFisica WHERE CPF = 'CPF do Estudante')));
-- Prova de Conceito:
-- Retorna o nome das disciplinas de estudo que o estudante com o CPF 'CPF do Estudante' está cursando.

-- Exemplo de consulta: Filtrar todos os estudantes matriculados em um determinado programa acadêmico.
-- Query:
SELECT * FROM PessoaFisica WHERE idPessoaFisica IN (SELECT idPessoaFisica FROM ProgramaAcademico WHERE nomeProgramaAcademico = 'Nome do Programa Acadêmico');
-- Prova de Conceito:
-- Retorna todos os dados dos estudantes matriculados no programa acadêmico cujo nome é 'Nome do Programa Acadêmico'.

-- Exemplo de consulta: Filtrar todos os estudantes matriculados em determinada disciplina de estudo.
-- Query:
SELECT * FROM PessoaFisica WHERE idPessoaFisica IN (SELECT idPessoaFisica FROM DisciplinaProgramaAcademico WHERE idDisciplinaEstudo = (SELECT idDisciplinaEstudo FROM DisciplinaEstudo WHERE nomeDisciplinaEstudo = 'Nome da Disciplina de Estudo'));
-- Prova de Conceito:
-- Retorna todos os dados dos estudantes matriculados na disciplina de estudo cujo nome é 'Nome da Disciplina de Estudo'.

-- Exemplo de consulta: Filtrar estudantes graduados.
-- Query:
SELECT * FROM PessoaFisica WHERE idPessoaFisica IN (SELECT idPessoaFisica FROM Graduacao);
-- Prova de Conceito:
-- Retorna todos os dados dos estudantes que se graduaram.

-- Exemplo de consulta: Filtrar estudantes ativos.
-- Query:
SELECT * FROM PessoaFisica WHERE idPessoaFisica IN (SELECT idPessoaFisica FROM Graduacao WHERE ativo = 1);
-- Prova de Conceito:
-- Retorna todos os dados dos estudantes ativos.

-- Exemplo de consulta: Apresentar a quantidade de estudantes ativos por programa acadêmico.
-- Query:
SELECT nomeProgramaAcademico, COUNT(*) AS Quantidade FROM PessoaFisica WHERE idPessoaFisica IN (SELECT idPessoaFisica FROM Graduacao WHERE ativo = 1) GROUP BY nomeProgramaAcademico;
-- Prova de Conceito:
-- Retorna o nome do programa acadêmico e a quantidade de estudantes ativos matriculados nele.

-- Exemplo de consulta: Apresentar a quantidade de estudantes ativos por disciplina de estudo.
-- Query:
SELECT nomeDisciplinaEstudo, COUNT(*) AS Quantidade FROM DisciplinaEstudo WHERE idDisciplinaEstudo IN (SELECT idDisciplinaEstudo FROM DisciplinaProgramaAcademico WHERE nomeProgramaAcademico IN (SELECT nomeProgramaAcademico FROM ProgramaAcademico WHERE idPessoaFisica IN (SELECT idPessoaFisica FROM Graduacao WHERE ativo = 1))) GROUP BY nomeDisciplinaEstudo;
-- Prova de Conceito:
-- Retorna o nome da disciplina de estudo e a quantidade de estudantes ativos matriculados nela.
