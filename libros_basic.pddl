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
  )

  (:action leer
    :parameters (?libro - libro ?pre - libro ?mes - mes)
    :precondition (and 
                    (not (leido ?libro))
                    (not (exists (?x - libro) (prerequisito ?libro ?x)))
                    
                  )
    :effect (and 
              (leido ?libro) 
              (assign (planificado_para ?libro) (numero_mes ?mes))
            )
  )
  
  (:action leer_pre
    :parameters (?libro - libro ?pre - libro ?mes - mes)
    :precondition (and 
                    (not (leido ?libro))
          
                
                     (and (prerequisito ?libro ?pre) (leido ?pre) (< (planificado_para ?pre) (numero_mes ?mes)))
                     
                   
                    
                  )
    :effect (and 
              (leido ?libro) 
              (increase (planificado_para ?libro) (numero_mes ?mes))
            )
  )
)