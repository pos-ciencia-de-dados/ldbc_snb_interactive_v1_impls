/* Q2. Recent messages by your friends */

SELECT * 
FROM cypher('agload_ldbc_graph', $$

	MATCH (:Person {id: $personId })-[:KNOWS]-(friend:Person)<-[:HAS_CREATOR]-(message)
	WHERE message.creationDate <= $maxDate
    RETURN
        friend.id AS personId,
        friend.firstName AS personFirstName,
        friend.lastName AS personLastName,
		message.id AS postOrCommentId,
		coalesce(message.content,message.imageFile) AS postOrCommentContent,
		message.creationDate AS postOrCommentCreationDate
	ORDER BY
		message.creationDate DESC,
        message.id ASC
    LIMIT 20

$$, ?) as (personId agtype, personFirstName agtype, personLastName agtype, postOrCommentId agtype, postOrCommentContent agtype, postOrCommentCreationDate agtype);