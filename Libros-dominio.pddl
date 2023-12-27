(define (domain planificacion-libros)
  (:requirements :strips :typing :negative-preconditions :disjunctive-preconditions)
  
  ;; Tipos
  (:types
    libro mes - objeto
  )

  ;; Predicados
  (:predicates
    (leido ?libro)
    (quiere-leer ?libro)
    (predecesor ?libro ?predecesor)
  )

  ;; Acciones
  (:action leer
    :parameters (?libro ?mes)
    :precondition (and 
                  (quiere-leer ?libro) (not (leido ?libro)) 
                  (or (not (exists (?p - libro) (and (predecesor ?libro ?p) (not (leido ?p)))))
                      (exists (?p - libro) (and (predecesor ?libro ?p) (leido ?p)))))
    :effect (and (leido ?libro))
  )
)
