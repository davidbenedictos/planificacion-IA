(define (problem planificacion-libros-problema)
  (:domain planificacion-libros)
  (:requirements :strips :typing)
  
  (:objects
    libro1 libro2 libro3 - libro
    enero febrero marzo abril mayo junio julio agosto septiembre octubre noviembre diciembre - mes
  )

  (:init
    (quiere-leer libro1)
    (quiere-leer libro2)
    (quiere-leer libro3)
    (predecesor libro2 libro1)
    (predecesor libro3 libro2)
  )

  (:goal (and (leido libro1) (leido libro2) (leido libro3)))
)
