using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Fade : MonoBehaviour
{
    private void Start()
    {

    }
    void Update()
    {
        if (Input.GetKeyUp(KeyCode.T))
        {
            StartCoroutine(FadeTo(0.0f, 1.0f));
        }
        if (Input.GetKeyUp(KeyCode.F))
        {
            StartCoroutine(FadeTo(1.0f, 1.0f));
        }
    }


    void ToAlpha()
    {

        float alpha = transform.GetComponent<Renderer>().material.color.a;

        while (alpha > 0)
        {

            alpha -= Time.deltaTime;
            print(alpha);
            Color newColor = new Color(1, 1, 1, alpha);
            transform.GetComponent<Renderer>().material.color = newColor;

        }

    }

        IEnumerator FadeTo(float aValue, float aTime)
    {
        float alpha = transform.GetComponent<Renderer>().material.color.a;
        for (float t = 0.0f; t < 1.0f; t += Time.deltaTime / aTime)
        {
            Color newColor = new Color(1, 1, 1, Mathf.Lerp(alpha, aValue, t));
            transform.GetComponent<Renderer>().material.color = newColor;
            yield return null;
        }
    }
}
