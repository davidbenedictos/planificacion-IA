(define (domain planificacion-libros)
  (:requirements :strips :typing :negative-preconditions)
  
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
                  (quiere-leer ?libro) (not (leido ?libro)))
    :effect (and (leido ?libro))
  )
)

