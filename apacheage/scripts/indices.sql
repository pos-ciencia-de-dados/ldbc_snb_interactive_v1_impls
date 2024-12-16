--
-- GET ID FUNCTION
--
CREATE OR REPLACE FUNCTION get_id(properties agtype) 
  RETURNS agtype
AS
$BODY$
    select agtype_access_operator($1, '"id"');
$BODY$
LANGUAGE sql
IMMUTABLE;

--
-- GET NAME FUNCTION
--
CREATE OR REPLACE FUNCTION get_name(properties agtype) 
  RETURNS agtype
AS
$BODY$
    select agtype_access_operator($1, '"name"');
$BODY$
LANGUAGE sql
IMMUTABLE;

--
-- GET CREATION DATE FUNCTION
--
CREATE OR REPLACE FUNCTION get_creationDate(properties agtype) 
  RETURNS agtype
AS
$BODY$
    select agtype_access_operator($1, '"creationDate"');
$BODY$
LANGUAGE sql
IMMUTABLE;

--
-- GET FIRST NAME FUNCTION
--
CREATE OR REPLACE FUNCTION get_firstName(properties agtype) 
  RETURNS agtype
AS
$BODY$
    select agtype_access_operator($1, '"firstName"');
$BODY$
LANGUAGE sql
IMMUTABLE;


CREATE UNIQUE INDEX city_id_idx ON agload_ldbc_graph."City"(get_id(properties));
CREATE UNIQUE INDEX comment_id_idx ON agload_ldbc_graph."Comment"(get_id(properties));
CREATE UNIQUE INDEX post_id_idx ON agload_ldbc_graph."Post"(get_id(properties));
CREATE UNIQUE INDEX country_id_idx ON agload_ldbc_graph."Country"(get_id(properties));
CREATE UNIQUE INDEX forum_id_idx ON agload_ldbc_graph."Forum"(get_id(properties));
CREATE UNIQUE INDEX company_id_idx ON agload_ldbc_graph."Company"(get_id(properties));
CREATE UNIQUE INDEX university_id_idx ON agload_ldbc_graph."University"(get_id(properties));
CREATE UNIQUE INDEX person_id_idx ON agload_ldbc_graph."Person"(get_id(properties));
CREATE UNIQUE INDEX tag_id_idx ON agload_ldbc_graph."Tag"(get_id(properties));

CREATE INDEX country_name_idx ON agload_ldbc_graph."Country"(get_name(properties));
CREATE INDEX comment_creationDate_idx ON agload_ldbc_graph."Comment"(get_creationDate(properties));
CREATE INDEX post_creationDate_idx ON agload_ldbc_graph."Post"(get_creationDate(properties));
CREATE INDEX person_firstName_idx ON agload_ldbc_graph."Person"(get_firstName(properties));
CREATE INDEX tag_name_idx ON agload_ldbc_graph."Tag"(get_name(properties));
CREATE INDEX tagClass_name_idx ON agload_ldbc_graph."TagClass"(get_name(properties));


-- CREATE INDEXES FOR QUERY_02
CREATE INDEX knows_startId_idx ON agload_ldbc_graph."KNOWS" USING btree (start_id);
CREATE INDEX knows_endId_idx ON agload_ldbc_graph."KNOWS" USING btree (end_id);
CREATE INDEX hasCreator_startId_idx ON agload_ldbc_graph."HAS_CREATOR" USING btree (start_id);
CREATE INDEX hasCreator_endId_idx ON agload_ldbc_graph."HAS_CREATOR" USING btree (end_id);


CREATE INDEX comment_creationDate_desc_idx ON agload_ldbc_graph."Comment"(get_creationDate(properties) DESC NULLS LAST);
CREATE INDEX post_creationDate_desc_idx ON agload_ldbc_graph."Post"(get_creationDate(properties) DESC NULLS LAST);

