(define (domain planificacion-libros)
  (:requirements :adl :typing :existential-preconditions :disjunctive-preconditions :fluents)
  
  (:types
    libro mes
  )

  (:functions
        (numero_mes ?mes - mes)                            
        (planificado_para ?libro - libro)
  )

  (:predicates
    (leido ?libro - libro)
    (prerequisito ?libro - libro ?pre - libro)
    (quiere_leer ?libro - libro)
  )

  (:action querer_prerequisito
    :parameters (?libro - libro ?pre - libro)
    :precondition (and 
                    (not (quiere_leer ?pre))
                    (prerequisito ?libro ?pre)
                    (quiere_leer ?libro)
                  )
    :effect (and 
              (quiere_leer ?pre) 
            )
  )
  
  (:action leer_sin_prerequisito
    :parameters (?libro - libro ?pre - libro ?mes - mes)
    :precondition (and
                    (quiere_leer ?libro)
                    (not (leido ?libro))
                    (not (exists (?x - libro) (prerequisito ?libro ?x)))
                  )
    :effect (and 
              (leido ?libro) 
              (assign (planificado_para ?libro) (numero_mes ?mes))
            )
  )

  (:action leer_con_prerequisito
    :parameters (?libro - libro ?pre - libro ?mes - mes)
    :precondition (and 
                    (quiere_leer ?libro)
                    (not (leido ?libro))
                    (and 
                      (prerequisito ?libro ?pre) (leido ?pre) 
                      (< (planificado_para ?pre) (numero_mes ?mes))
                    ) 
                  )
    :effect (and 
              (leido ?libro) 
              (assign (planificado_para ?libro) (numero_mes ?mes))
            )
  )
)