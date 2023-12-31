(define (domain planificacion-libros)
  (:requirements :adl :typing :existential-preconditions :fluents)
  
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
    (paralelo ?libro1 - libro ?libro2 - libro)
  )

  (:action leer
    :parameters (?libro - libro ?pre - libro ?mes - mes)
    :precondition (and 
                    (not (leido ?libro))
                    (not (exists (?x - libro) (prerequisito ?libro ?x)))
                    (not (exists(?x - libro) (paralelo ?libro ?x)))
                    
                  )
    :effect (and 
              (leido ?libro) 
              (assign (planificado_para ?libro) (numero_mes ?mes))
            )
  )

  (:action leer_pre
  :parameters (?libro - libro ?mes - mes)
  :precondition (and 
                  (not (leido ?libro))
                  (or 
                    (not (exists (?x - libro) (prerequisito ?libro ?x)))
                    (forall (?pre - libro) 
                      (or 
                        (not (prerequisito ?libro ?pre))
                        (and (prerequisito ?libro ?pre) (leido ?pre) (< (planificado_para ?pre) (numero_mes ?mes)))
                      )
                    )
                  )
                )
  :effect (and 
            (leido ?libro) 
            (increase (planificado_para ?libro) (numero_mes ?mes))
          )
  )

  (:action leer_paralelo
  :parameters (?libro - libro ?mes - mes)
  :precondition (and 
                  (not (leido ?libro))
                  (or 
                    (forall (?paralelo - libro) 
                      (or 
                        (not (paralelo ?libro ?paralelo))
                        (or 
                            (and (paralelo ?libro ?paralelo) (leido ?paralelo) (<= (planificado_para ?paralelo) (numero_mes ?mes)))
                            ; leetelo el este mes
                            )
                      )
                    )
                  )
                )
  :effect (and 
            (leido ?libro) 
            (increase (planificado_para ?libro) (numero_mes ?mes))
          )
  )
)