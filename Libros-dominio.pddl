(define (domain planificacion-libros)
  (:requirements :strips :typing :negative-preconditions :disjunctive-preconditions :fluents)
  
  ;; Tipos
  (:types
    libro mes - objeto
  )

  (:functions
    (numero_mes ?m - mes)
    (fecha ?l - libro) ;; Fecha en la que esta programada la lectura del libro l
  )

  ;; Predicados
  (:predicates
    (leido ?l - libro)
    (quiere_leer ?l - libro) 
    (predecesor ?l - libro ?p - libro) ;; para leer l hay que haber leído p
  )

  ;; Acciones
  (:action leer
    :parameters (?l - libro ?m - mes ?p - libro)
    :precondition (and 
                    (quiere-leer ?l) (not (leido ?l)) 
                    (or 
                      (not (exists (?p1 - libro) (predecesor ?p1 ?l)))
                      (and (predecesor ?l ?p) (leido ?p) (<= (fecha ?p) (numero_mes ?m)))
                    )          
                  )
    :effect (and (leido ?l) (fecha ?l (numero_mes ?m)))
  )
)
