CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER,

  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  body TEXT NOT NULL,
  parent_id INTEGER,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (parent_id) REFERENCES replies(question_id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

  INSERT INTO
    users (fname, lname)
  VALUES
    ('John', 'Johnson'),
    ('Bjorn', 'Stroem'),
    ('Anderson', 'Cooper');

  INSERT INTO
    questions (title, body, user_id)
  VALUES
    ('turtles', 'how often do turtles have to find new shells',
      (SELECT id FROM users WHERE fname = 'John' AND lname = 'Johnson')),
    ('volcanoes', 'best way to cook meat over a volcanoe',
      (SELECT id FROM users WHERE fname = 'Bjorn' AND lname = 'Stroem'));

  INSERT INTO
    question_follows (user_id, question_id)
  VALUES
    ((SELECT id FROM users WHERE fname = 'Anderson' AND lname = 'Cooper'),
      (SELECT id FROM questions WHERE title = 'volcanoes'));

  INSERT INTO
    replies (question_id, user_id, body)
  VALUES
    ((SELECT id FROM questions WHERE title = 'turtles'),
    (SELECT id FROM users WHERE fname = 'Bjorn' ),
    'about once a month, like hermit crabs. (hermit crabs are the larval form of turtles)');

    INSERT INTO
      replies (question_id, user_id, parent_id, body)
    VALUES
      ((SELECT id FROM questions WHERE title = 'turtles'),
      (SELECT id FROM users WHERE fname = 'Anderson' ),
      (SELECT id FROM replies WHERE id = 1),
      'Tonight at 11: Missing link in turtle evolution FOUND!');

  INSERT INTO
    question_likes (user_id, question_id)
  VALUES
    ((SELECT id FROM users WHERE fname = 'Anderson' AND lname = 'Cooper'),
    (SELECT id FROM questions WHERE title = 'turtles'));
